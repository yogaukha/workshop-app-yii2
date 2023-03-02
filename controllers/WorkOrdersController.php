<?php

namespace app\controllers;

use Yii;
use Mpdf\Mpdf;
use app\models\WorkOrders;
use app\models\WorkOrderDetails;
use app\models\WorkOrderDetailsService;
use app\models\WorkOrderDetailsSparepart;
use app\models\search\WorkOrdersSearch;
use app\models\Spareparts;
use app\models\Services;
use app\models\ServicePrices;
use app\models\LastNumber;
use app\models\Customers;
use app\models\Categories;
use app\models\Generals;
use app\models\Users;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\ArrayHelper;
use yii\helpers\Html;

/**
 * WorkOrdersController implements the CRUD actions for WorkOrders model.
 */
class WorkOrdersController extends HomeController
{
    /**
     * @inheritDoc
     */
    public function behaviors()
    {
        return array_merge(
            parent::behaviors(),
            [
                'verbs' => [
                    'class' => VerbFilter::className(),
                    'actions' => [
                        'delete' => ['POST'],
                    ],
                ],
            ]
        );
    }

    /**
     * Lists all WorkOrders models.
     *
     * @return string
     */
    public function actionIndex()
    {
        $searchModel = new WorkOrdersSearch();
        $dataProvider = $searchModel->search($this->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single WorkOrders model.
     * @param string $id ID
     * @return string
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id, $print = 0)
    {
        $model = $this->findModel($id);
        $modelDetailService = WorkOrderDetailsService::find()
                                ->where(['work_order_id' => $id])
                                ->andWhere(['!=', 'is_deleted', '1'])
                                ->andWhere(['!=', 'service_id', ''])
                                ->all();
        $modelDetailSparepart = WorkOrderDetailsSparepart::find()
                                ->select('work_order_details.manual_price, work_order_details.manual_discount, work_order_details.subtotal, spareparts.name as sparepart_id')
                                ->innerJoin('spareparts', '`spareparts`.`id` = `work_order_details`.`sparepart_id`')
                                ->where(['work_order_id' => $id])
                                ->andWhere(['!=', 'work_order_details.is_deleted', '1'])
                                ->andWhere(['!=', 'spareparts.is_deleted', '1'])
                                ->andWhere(['!=', 'sparepart_id', ''])
                                ->all();
        $modelCustomer = Customers::find()
                        ->select(['customers.*', 'categories.name as category_name'])
                        ->innerJoin('categories', '`categories`.`id` = `customers`.`category_id`')
                        ->where(['customers.id' => $model->customer_id])
                        ->andWhere(['=', 'customers.is_deleted', '0'])
                        ->andWhere(['=', 'categories.is_deleted', '0'])
                        ->one();
        $categories = ArrayHelper::map(Categories::find()->where(['is_deleted' => 0])->all(), 'id', 'name');
        $services = ArrayHelper::map(Services::find()->where(['is_deleted' => 0])->all(), 'id', 'name');
        $model->entry_date = date('d-m-Y', strtotime($model->entry_date));

        return $this->render('view', [
            'model' => $model,
            'modelDetailService' => $modelDetailService,
            'modelDetailSparepart' => $modelDetailSparepart,
            'modelCustomer' => $modelCustomer,
            'categories' => $categories,
            'services' => $services,
            'print' => $print
        ]);
    }

    /**
     * Creates a new WorkOrders model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return string|\yii\web\Response
     */
    public function actionCreate()
    {
        $model = new WorkOrders();
        $modelDetailService = [new WorkOrderDetailsService];
        $modelDetailSparepart = [new WorkOrderDetailsSparepart];
        $modelCustomer = new Customers();
        $categories = ArrayHelper::map(Categories::find()->where(['is_deleted' => 0])->all(), 'id', 'name');
        $services = ArrayHelper::map(Services::find()->where(['is_deleted' => 0])->all(), 'id', 'name');
        $lastNumber = LastNumber::find()->one()->last_work_order_number;
        $model->number = 'RD25.' . str_pad(($lastNumber+1), 6, 0, STR_PAD_LEFT);
        $model->status = 'Pribadi';
        $model->entry_date = date('d-m-Y');
        // $modelCustomer->category_id = '8e6d536d-ad44-11ed-8716-0492260c7ca0'; // TODO, JANGAN LUPA DIHAPUS / DICOMMENT

        if ($this->request->isPost) {
            $transaction = Yii::$app->db->beginTransaction();
            try {
                $oldCustomer = Customers::find()->where(['license_plate' => $this->request->post('Customers')['license_plate']])->one();
                if (!empty($oldCustomer)) {
                    $oldCustomer->attributes = $this->request->post('Customers');
                    $oldCustomer->updatedby = parent::getUsername();
                    $oldCustomer->updatedtime = date('Y-m-d H:i:s');
                    $modelCustomer = $oldCustomer;
                } else {
                    $modelCustomer->attributes = $this->request->post('Customers');
                    $modelCustomer->createdby = parent::getUsername();
                }
                if ($modelCustomer->save()) {
                    $customerLastInserted = Customers::find()->where(['license_plate' => $modelCustomer->license_plate])->one();
                
                    $model->attributes = $this->request->post('WorkOrders');
                    $model->entry_date = date('Y-m-d', strtotime($model->entry_date));
                    $model->completion_date = date('Y-m-d', strtotime($model->completion_date));
                    $model->customer_id = $customerLastInserted->id;
                    $model->createdby = parent::getUsername();

                    if ($model->save()) {
                        $workOrderLastInserted = WorkOrders::find()->orderBy('createdtime DESC')->one();
                        $workOrderDetails = array_merge($this->request->post('WorkOrderDetailsService'), $this->request->post('WorkOrderDetailsSparepart'));

                        foreach ($workOrderDetails as $row) {

                            if (!empty($row['sparepart_id'])) {
                                $modelSparepart = Spareparts::find()->where(['name' => $row['sparepart_id']])->one();
                                if (empty($modelSparepart)) {
                                    $modelSparepart = new Spareparts();
                                    $modelSparepart->createdby = parent::getUsername();
                                } else {
                                    $modelSparepart->updatedby = parent::getUsername();
                                    $modelSparepart->updatedtime = date('Y-m-d H:i:s');
                                }
                                $modelSparepart->name = $row['sparepart_id'];
                                $modelSparepart->price = $row['manual_price'];
                                if (!$modelSparepart->save()) {
                                    $transaction->rollBack();
                                    var_dump($modelSparepart->errors);
                                    return $this->render('create', [
                                        'model' => $model,
                                        'modelDetailService' => $modelDetailService,
                                        'modelDetailSparepart' => $modelDetailSparepart,
                                        'modelCustomer' => $modelCustomer,
                                        'categories' => $categories,
                                        'services' => $services,
                                    ]);
                                }
                                $lastInsertSparepart = Spareparts::find()->where(['name' => $row['sparepart_id']])->one();
                            }

                            $modelWorkOrderDetail = new WorkOrderDetails();
                            $modelWorkOrderDetail->work_order_id = $workOrderLastInserted->id;
                            $modelWorkOrderDetail->service_id = !empty($row['service_id']) ? $row['service_id'] : '';
                            $modelWorkOrderDetail->sparepart_id = !empty($lastInsertSparepart) ? $lastInsertSparepart->id : '';
                            $modelWorkOrderDetail->manual_price = $row['manual_price'];
                            $modelWorkOrderDetail->manual_discount = $row['manual_discount'];
                            $modelWorkOrderDetail->subtotal = $row['subtotal'];
                            $modelWorkOrderDetail->createdby = parent::getUsername();
                            if (!$modelWorkOrderDetail->save()) {
                                $transaction->rollBack();
                                var_dump($modelWorkOrderDetail->errors);
                                return $this->render('create', [
                                    'model' => $model,
                                    'modelDetailService' => $modelDetailService,
                                    'modelDetailSparepart' => $modelDetailSparepart,
                                    'modelCustomer' => $modelCustomer,
                                    'categories' => $categories,
                                    'services' => $services,
                                ]);
                            }

                        }
                        $lastNumber = LastNumber::find()->where(['id' => '568dbcd8-b445-11ed-abe4-0492260c7ca0'])->one();
                        $lastNumber->last_work_order_number = $lastNumber->last_work_order_number + 1;
                        if (!$lastNumber->save()) {
                            $transaction->rollBack();
                            var_dump($lastNumber->errors);
                            return $this->render('create', [
                                'model' => $model,
                                'modelDetailService' => $modelDetailService,
                                'modelDetailSparepart' => $modelDetailSparepart,
                                'modelCustomer' => $modelCustomer,
                                'categories' => $categories,
                                'services' => $services,
                            ]);
                        }
                    } else {
                        $transaction->rollBack();
                        var_dump($model->errors);
                        return $this->render('create', [
                            'model' => $model,
                            'modelDetailService' => $modelDetailService,
                            'modelDetailSparepart' => $modelDetailSparepart,
                            'modelCustomer' => $modelCustomer,
                            'categories' => $categories,
                            'services' => $services,
                        ]);
                    }
                } else {
                    $transaction->rollBack();
                    var_dump($modelCustomer->errors);
                    return $this->render('create', [
                        'model' => $model,
                        'modelDetailService' => $modelDetailService,
                        'modelDetailSparepart' => $modelDetailSparepart,
                        'modelCustomer' => $modelCustomer,
                        'categories' => $categories,
                        'services' => $services,
                    ]);
                }
                $transaction->commit();
                
                // return $this->redirect(['index']);
                return $this->redirect(['view', 'id' => $model->id, 'print' => 1]);
            } catch(Exception $e) {
                $transaction->rollBack();
                throw $e;
            }
        } else {
            $model->loadDefaultValues();
        }

        return $this->render('create', [
            'model' => $model,
            'modelDetailService' => $modelDetailService,
            'modelDetailSparepart' => $modelDetailSparepart,
            'modelCustomer' => $modelCustomer,
            'categories' => $categories,
            'services' => $services,
        ]);
    }

    /**
     * Updates an existing WorkOrders model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param string $id ID
     * @return string|\yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $modelDetailService = WorkOrderDetailsService::find()->where(['work_order_id' => $id])->andWhere(['!=', 'service_id', ''])->all();
        $modelDetailSparepart = WorkOrderDetailsSparepart::find()
                                ->select('work_order_details.manual_price, work_order_details.manual_discount, work_order_details.subtotal, spareparts.name as sparepart_id')
                                ->innerJoin('spareparts', '`spareparts`.`id` = `work_order_details`.`sparepart_id`')
                                ->where(['work_order_id' => $id])
                                ->andWhere(['!=', 'sparepart_id', ''])
                                ->all();
        $modelCustomer = Customers::find()->where(['id' => $model->customer_id])->one();
        $categories = ArrayHelper::map(Categories::find()->where(['is_deleted' => 0])->all(), 'id', 'name');
        $services = ArrayHelper::map(Services::find()->where(['is_deleted' => 0])->all(), 'id', 'name');
        $model->entry_date = date('d-m-Y', strtotime($model->entry_date));
        
        if ($this->request->isPost) {
            $transaction = Yii::$app->db->beginTransaction();
            try {
                $modelCustomer->attributes = $this->request->post('Customers');
                $modelCustomer->updatedby = parent::getUsername();
                $modelCustomer->updatedtime = date('Y-m-d H:i:s');
                if ($modelCustomer->update()) {
                    $customerLastInserted = Customers::find()->where(['license_plate' => $modelCustomer->license_plate])->one();
                
                    $model->attributes = $this->request->post('WorkOrders');
                    $model->entry_date = date('Y-m-d', strtotime($model->entry_date));
                    $model->completion_date = date('Y-m-d', strtotime($model->completion_date));
                    $model->customer_id = $customerLastInserted->id;
                    $model->updatedby = parent::getUsername();
                    $model->updatedtime = date('Y-m-d H:i:s');

                    if ($model->update()) {
                        // delete all work order details
                        $workOrderDetailsDelete = WorkOrderDetails::deleteAll(['work_order_id' => $model->id]);

                        $workOrderDetails = array_merge($this->request->post('WorkOrderDetailsService'), $this->request->post('WorkOrderDetailsSparepart'));
                        foreach ($workOrderDetails as $row) {

                            if (!empty($row['sparepart_id'])) {
                                $modelSparepart = Spareparts::find()->where(['name' => $row['sparepart_id']])->one();
                                if (empty($modelSparepart)) {
                                    $modelSparepart = new Spareparts();
                                    $modelSparepart->createdby = parent::getUsername();
                                } else {
                                    $modelSparepart->updatedby = parent::getUsername();
                                    $modelSparepart->updatedtime = date('Y-m-d H:i:s');
                                }
                                $modelSparepart->name = $row['sparepart_id'];
                                $modelSparepart->price = $row['manual_price'];
                                if (!$modelSparepart->save()) {
                                    $transaction->rollBack();
                                    var_dump($modelSparepart->errors);
                                }
                                $lastInsertSparepart = Spareparts::find()->where(['name' => $row['sparepart_id']])->one();
                            }

                            $modelWorkOrderDetail = new WorkOrderDetails();
                            $modelWorkOrderDetail->work_order_id = $model->id;
                            $modelWorkOrderDetail->service_id = !empty($row['service_id']) ? $row['service_id'] : '';
                            $modelWorkOrderDetail->sparepart_id = !empty($lastInsertSparepart) ? $lastInsertSparepart->id : '';
                            $modelWorkOrderDetail->manual_price = $row['manual_price'];
                            $modelWorkOrderDetail->manual_discount = $row['manual_discount'];
                            $modelWorkOrderDetail->subtotal = $row['subtotal'];
                            $modelWorkOrderDetail->createdby = parent::getUsername();

                            if (!$modelWorkOrderDetail->save()) {
                                $transaction->rollBack();
                                var_dump($modelWorkOrderDetail->errors);
                            }

                        }
                    } else {
                        $transaction->rollBack();
                        var_dump($model->errors);
                    }
                } else {
                    $transaction->rollBack();
                    var_dump($modelCustomer->errors);
                }
                $lastNumber = LastNumber::find()->where(['id' => '568dbcd8-b445-11ed-abe4-0492260c7ca0'])->one();
                $lastNumber->last_work_order_number = $lastNumber->last_work_order_number + 1;
                if (!$lastNumber->save()) {
                    $transaction->rollBack();
                    var_dump($lastNumber->errors);
                }
                $transaction->commit();
                
                return $this->redirect(['index']);
            } catch(Exception $e) {
                $transaction->rollBack();
                throw $e;
            }
        }

        return $this->render('update', [
            'model' => $model,
            'modelDetailService' => $modelDetailService,
            'modelDetailSparepart' => $modelDetailSparepart,
            'modelCustomer' => $modelCustomer,
            'categories' => $categories,
            'services' => $services
        ]);
    }

    /**
     * Deletes an existing WorkOrders model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param string $id ID
     * @return \yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        $model = $this->findModel($id);

        if ($this->request->isPost) {
            $transaction = Yii::$app->db->beginTransaction();
            try {
                $model->is_deleted = 1;
                $model->updatedtime = date('Y-m-d H:i:s');
                $model->updatedby = parent::getUsername();
                if ($model->update() ) {
                    // set all service prices to deleted
                    $command = Yii::$app->db->createCommand(
                        "UPDATE service_prices
                        SET is_deleted = 1,
                        updatedby = '" . parent::getUsername() . "',
                        updatedtime = '" . date('Y-m-d H:i:s') . "'
                        WHERE is_deleted = 0
                        AND service_id = '" . $id . "'"
                    );
                    $command->execute();
                }
                $transaction->commit();
                return $this->redirect(['index']);
            } catch(Exception $e) {
                $transaction->rollBack();
                throw $e;
            }
        }

        return $this->redirect(['index']);
    }

    /**
     * Finds the WorkOrders model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param string $id ID
     * @return WorkOrders the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = WorkOrders::findOne(['id' => $id])) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('Halaman tidak ditemukan.');
    }

    public function actionGetPrice ($service_id, $category_id) {
        $modelServicePrices = ServicePrices::find()->where(['service_id' => $service_id, 'category_id' => $category_id])->one();
        if ($modelServicePrices) {
            return $modelServicePrices->price;
        }

        return '';
    }

    public function actionGetCustomer ($license_plate) {
        \Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        $modelCustomer = Customers::find()->where(['license_plate' => $license_plate])->asArray()->one();
        if ($modelCustomer) {
            return $modelCustomer;
        }

        return [];
    }

    public function actionPrint ($id) {
        $model = $this->findModel($id);
        $modelGeneral = Generals::find()->where(['name' => 'LOGO_PERUSAHAAN'])->andWhere(['!=', 'is_deleted', 1])->one();
        $modelUser = Users::find()
                    ->innerJoin('roles', 'roles.id = users.role_id')
                    ->where(['roles.name' => 'Service Advisor'])
                    ->andWhere(['=', 'roles.is_deleted', '0'])
                    ->andWhere(['=', 'users.is_deleted', '0'])
                    ->one();
        $modelCustomer = Customers::find()
                        ->select(['customers.*', 'categories.name as category_name'])
                        ->innerJoin('categories', '`categories`.`id` = `customers`.`category_id`')
                        ->where(['customers.id' => $model->customer_id])
                        ->andWhere(['=', 'customers.is_deleted', '0'])
                        ->andWhere(['=', 'categories.is_deleted', '0'])
                        ->one();
        $modelDetailService = WorkOrderDetailsService::find()
                                ->select('work_order_details.manual_price, work_order_details.manual_discount, work_order_details.subtotal, services.name as service_name')
                                ->innerJoin('services', '`services`.`id` = `work_order_details`.`service_id`')
                                ->where(['work_order_id' => $id])
                                ->andWhere(['!=', 'services.is_deleted', '1'])
                                ->andWhere(['!=', 'work_order_details.is_deleted', '1'])
                                ->andWhere(['!=', 'service_id', ''])
                                ->all();
        $modelDetailSparepart = WorkOrderDetailsSparepart::find()
                                ->select('work_order_details.manual_price, work_order_details.manual_discount, work_order_details.subtotal, spareparts.name as sparepart_name')
                                ->innerJoin('spareparts', '`spareparts`.`id` = `work_order_details`.`sparepart_id`')
                                ->where(['work_order_id' => $id])
                                ->andWhere(['!=', 'work_order_details.is_deleted', '1'])
                                ->andWhere(['!=', 'spareparts.is_deleted', '1'])
                                ->andWhere(['!=', 'sparepart_id', ''])
                                ->all();
        $pdf = new Mpdf(['margin_top' => 73, 'margin-left' => 0, 'margin-right' => 0, 'tempDir' => sys_get_temp_dir().DIRECTORY_SEPARATOR.'mpdf', 'format' => [210, 140], 'setAutoTopMargin' => false]);
        $pdf->imageVars['logord25'] = file_get_contents(Yii::getAlias('@webroot') . '/' . $modelGeneral->value);
        $pdf->SetHTMLHeader('
            <table class="TableGrid">
            <tr>
                <td style="width: 71%">
                    ' . Html::img('var:logord25', ['width' => '2.5cm']) . '
                </td>
                <td style="font-size: 10px;">
                    Bengkel Cat Solo RD-25 AUTO BODY
                    <br>
                    9QHR+4PQ, Pd. III, Pondok, Kec. Grogol, Kabupaten Sukoharjo, Jawa Tengah 57552
                    <br>
                    Telp. 0815-7816-8823
                </td>
            </tr>
            </table>
            <hr>
            <table class="TableGrid">
            <tr>
                <td style="font-size: 12px;">
                    <center>
                        <b>PERINTAH KERJA BENGKEL</b>
                        <br>
                        <div style="font-size: 14px;">NO. <b style="font-size: 14px;">' . $model->number . '</b></div>
                        Status : ' . $model->status . '
                    </center>
                </td>
            </tr>
            </table>
            <hr>
            <table class="TableGrid" style="margin-left: 150px; margin-right: auto; font-size: 10px;">
            <tr>
                <td width="15%">
                    No. Polisi
                </td>
                <td width="2%">
                    :
                </td>
                <td width="29%">
                    ' . $modelCustomer->license_plate . '
                </td>
                <td width="15%">
                    Tanggal Masuk
                </td>
                <td width="2%">
                    :
                </td>
                <td width="46%">
                    ' . date('d-m-Y', strtotime($model->entry_date)) . '
                </td>
            </tr>
            <tr>
                <td width="15%">
                    Merk / Tipe
                </td>
                <td width="2%">
                    :
                </td>
                <td width="29%">
                    ' . $modelCustomer->brand . ' / ' . $modelCustomer->type . '
                </td>
                <td width="15%">
                    Tanggal Keluar
                </td>
                <td width="2%">
                    :
                </td>
                <td width="46%">
                    ' . date('d-m-Y', strtotime($model->completion_date)) . '
                </td>
            </tr>
            <tr>
                <td width="15%">
                    Warna
                </td>
                <td width="2%">
                    :
                </td>
                <td width="29%">
                    ' . $modelCustomer->color . '
                </td>
                <td width="15%">
                    Nama Customer
                </td>
                <td width="2%">
                    :
                </td>
                <td width="46%">
                    ' . $modelCustomer->name . '
                </td>
            </tr>
            <tr>
                <td width="15%">
                    Tahun
                </td>
                <td width="2%">
                    :
                </td>
                <td width="29%">
                    ' . $modelCustomer->year . '
                </td>
                <td width="15%">
                    No. Telp
                </td>
                <td width="2%">
                    :
                </td>
                <td width="46%">
                    ' . $modelCustomer->phone_number . '
                </td>
            </tr>
            <tr>
                <td width="15%">
                    Nomor Rangka
                </td>
                <td width="2%">
                    :
                </td>
                <td width="29%">
                    ' . $modelCustomer->vehicle_identification_number . '
                </td>
                <td width="15%">
                    Email
                </td>
                <td width="2%">
                    :
                </td>
                <td width="46%">
                    ' . $modelCustomer->email . '
                </td>
            </tr>
            <tr>
                <td width="15%" style="vertical-align: top;">
                    Nomor Mesin
                </td>
                <td width="2%" style="vertical-align: top;">
                    :
                </td>
                <td width="29%" style="vertical-align: top;">
                    ' . $modelCustomer->engine_number . '
                </td>
                <td width="15%" style="vertical-align: top;">
                    Alamat
                </td>
                <td width="2%" style="vertical-align: top;">
                    :
                </td>
                <td width="46%" style="vertical-align: top;">
                    ' . $modelCustomer->address . '
                </td>
            </tr>
            </table>
            <hr>
        ');
        $pdf->WriteHTML(
            // return Yii::$app->view->renderFile(
            Yii::$app->view->renderFile(
                '@app/views/printout/pkb.php', [
                    'model' => $model,
                    'modelUser' => $modelUser,
                    'modelCustomer' => $modelCustomer,
                    'modelDetailService' => $modelDetailService,
                    'modelDetailSparepart' => $modelDetailSparepart
                ]
            )
            // );
        );
        $pdf->SetTitle($modelCustomer->license_plate);
        $pdf->Output($modelCustomer->license_plate . ' - RD25.pdf', 'I');
    }
}