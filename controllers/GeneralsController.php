<?php

namespace app\controllers;

use app\controllers\HomeController;
use app\models\Generals;
use app\models\search\GeneralsSearch;
use Yii;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\UploadedFile;

/**
 * GeneralsController implements the CRUD actions for Generals model.
 */
class GeneralsController extends HomeController
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
     * Lists all Generals models.
     *
     * @return string
     */
    public function actionIndex()
    {
        $searchModel = new GeneralsSearch();
        $dataProvider = $searchModel->search($this->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Generals model.
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
     * Creates a new Generals model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return string|\yii\web\Response
     */
    public function actionCreate()
    {
        $model = new Generals();

        if ($this->request->isPost) {
            $model->name = $this->request->post('Generals')['name'];
            $model->type = $this->request->post('Generals')['type'];
            $model->image = UploadedFile::getInstance($model, 'image');
            $model->createdby = parent::getUsername();
            if ($model->validate()) {
                $model->value = $model->type == 'Gambar' ? $model->upload() : $model->value;
                $model->save(false);

                return $this->redirect(['index']);
            }
        } else {
            $model->loadDefaultValues();
        }

        return $this->render('create', [
            'model' => $model,
        ]);
    }

    /**
     * Updates an existing Generals model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param string $id ID
     * @return string|\yii\web\Response
     * @throws NotFoundHttpException if the model cannot be found
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);
        
        if ($this->request->isPost) {
            $model->name = $this->request->post('Generals')['name'];
            $model->type = $this->request->post('Generals')['type'];
            $model->image = UploadedFile::getInstance($model, 'image');
            $model->updatedtime = date('Y-m-d H:i:s');
            $model->updatedby = parent::getUsername();

            $absolutePath = Yii::getAlias('@webroot') . '/' . $model->value;
            if ($model->type == 'Gambar' && file_exists($absolutePath) && !empty($model->image)) {
                unlink($absolutePath);
            }

            if ($model->validate()) {
                $model->value = !empty($model->image) ? $model->upload() : $model->value;
                $model->save(false);

                return $this->redirect(['index']);
            }
        }

        return $this->render('update', [
            'model' => $model,
        ]);
    }

    /**
     * Deletes an existing Generals model.
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
            $model->update();
        }

        return $this->redirect(['index']);
    }

    /**
     * Finds the Generals model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param string $id ID
     * @return Generals the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Generals::findOne(['id' => $id])) !== null) {
            return $model;
        }

        throw new NotFoundHttpException('Halaman tidak ditemukan.');
    }
}
