<?php

namespace app\controllers;

use Yii;
use app\models\Customers;
use app\models\Categories;
use app\models\WorkOrders;
use app\models\search\CustomersSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\helpers\ArrayHelper;

/**
 * CustomersController implements the CRUD actions for Customers model.
 */
class CustomersController extends HomeController
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
     * Lists all Customers models.
     *
     * @return string
     */
    public function actionIndex()
    {
        $searchModel = new CustomersSearch();
        $dataProvider = $searchModel->search($this->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Customers model.
     * @param string $id ID
     * @return string
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionView($id)
    {
        $model = Customers::find()
                ->select(['customers.*', 'categories.name as category_name'])
                ->innerJoin('categories', '`categories`.`id` = `customers`.`category_id`')
                ->where(['customers.id' => $id])
                ->andWhere(['=', 'customers.is_deleted', '0'])
                ->andWhere(['=', 'categories.is_deleted', '0'])
                ->one();
        $modelWorkOrders = WorkOrders::findAll(['customer_id' => $id]);

        return $this->render('view', [
            'model' => $model,
            'modelWorkOrders' => $modelWorkOrders
        ]);
    }

    /**
     * Creates a new Customers model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return string|\yii\web\Response
     */
    public function actionCreate()
    {
        $model = new Customers();
        $modelCategory = Categories::find()->all();
        $modelServicePrices = new ServicePrices();

        if ($this->request->isPost) {
            if ($model->load($this->request->post())) {
                $model->createdby = parent::getUsername();
                if (!$model->save()) {
                    var_dump($model->errors);die;
                }
            }
            
            return $this->redirect(['index']);
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
     * Updates an existing Customers model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param string $id ID
     * @return string|\yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        $modelCategory = Categories::find()->all();
        
        if ($this->request->isPost) {
            if ($model->load($this->request->post())) {
                $model->updatedtime = date('Y-m-d H:i:s');
                $model->updatedby = parent::getUsername();
                if (!$model->update()) {
                    var_dump($model->errors);die;
                }
            }
            
            return $this->redirect(['index']);
        }

        return $this->render('update', [
            'model' => $model,
            'modelCategory' => $modelCategory
        ]);
    }

    /**
     * Deletes an existing Customers model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param string $id ID
     * @return \yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionDelete($id)
    {
        $model = $this->findModel($id);

        if ($this->request->isPost) {
            $model->is_deleted = 1;
            $model->updatedtime = date('Y-m-d H:i:s');
            $model->updatedby = parent::getUsername();
            if (!$model->update() ) {
                var_dump($model->errors);die;
            }
            return $this->redirect(['index']);
        }

        return $this->redirect(['index']);
    }

    /**
     * Finds the Customers model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param string $id ID
     * @return Customers the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Customers::findOne(['id' => $id])) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('Halaman tidak ditemukan.');
    }
}
