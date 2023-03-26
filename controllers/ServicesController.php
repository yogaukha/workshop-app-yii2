<?php

namespace app\controllers;

use Yii;
use app\models\Services;
use app\models\ServicePrices;
use app\models\Categories;
use app\models\search\ServicesSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\ArrayHelper;

/**
 * ServicesController implements the CRUD actions for Services model.
 */
class ServicesController extends HomeController
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
     * Lists all Services models.
     *
     * @return string
     */
    public function actionIndex()
    {
        $searchModel = new ServicesSearch();
        $dataProvider = $searchModel->search($this->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Services model.
     * @param string $id ID
     * @return string
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Services model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return string|\yii\web\Response
     */
    public function actionCreate()
    {
        $model = new Services();
        $modelCategory = Categories::find()->where(['is_deleted' => 0])->all();
        $modelServicePrices = new ServicePrices();

        if ($this->request->isPost) {
            $transaction = Yii::$app->db->beginTransaction();
            try {
                if ($model->load($this->request->post())) {
                    $model->createdby = parent::getUsername();
                    if ($model->save()) {
                        $serviceLastInserted = Services::find()->where(['name' => $model->name])->one();
                        foreach ($this->request->post('ServicePrices') as $row) {
                            $servicePrices = new ServicePrices();
                            $servicePrices->category_id = $row['category_id'];
                            $servicePrices->service_id = $serviceLastInserted->id;
                            $servicePrices->price = $row['price'];
                            $servicePrices->createdby = parent::getUsername();
                            if (!$servicePrices->save()) {
                                $transaction->rollBack();
                                return $this->redirect(['index']);
                            }
                        }
                    }
                }
                $transaction->commit();
                
                return $this->redirect(['index']);
            } catch(Exception $e) {
                $transaction->rollBack();
                throw $e;
            }
        } else {
            $model->loadDefaultValues();
        }

        return $this->render('create', [
            'model' => $model,
            'modelCategory' => $modelCategory,
            'modelServicePrices' => $modelServicePrices
        ]);
    }

    /**
     * Updates an existing Services model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param string $id ID
     * @return string|\yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $modelCategory = Categories::find()->where(['is_deleted' => 0])->all();
        $modelServicePrices = ServicePrices::find()->where(['service_id' => $id, 'is_deleted' => 0])->all();
        
        if ($this->request->isPost) {
            $transaction = Yii::$app->db->beginTransaction();
            try {
                if ($model->load($this->request->post())) {
                    $model->updatedtime = date('Y-m-d H:i:s');
                    $model->updatedby = parent::getUsername();
                    if ($model->update()) {
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

                        // then insert new row (all data)
                        foreach ($this->request->post('ServicePrices') as $row) {
                            $servicePrices = new ServicePrices();
                            $servicePrices->category_id = $row['category_id'];
                            $servicePrices->service_id = $model->id;
                            $servicePrices->price = $row['price'];
                            $servicePrices->createdby = parent::getUsername();
                            if (!$servicePrices->save()) {
                                $transaction->rollBack();
                                var_dump($servicePrices->errors());
                                return $this->redirect(['index']);
                            }
                        }
                    }
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
            'modelCategory' => $modelCategory,
            'modelServicePrices' => $modelServicePrices
        ]);
    }

    /**
     * Deletes an existing Services model.
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
     * Finds the Services model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param string $id ID
     * @return Services the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Services::findOne(['id' => $id])) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('Halaman tidak ditemukan.');
    }
}
