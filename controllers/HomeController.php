<?php

namespace app\controllers;

use Yii;
use app\models\Users;
use app\models\WorkOrders;
use app\models\Customers;
use yii\filters\AccessControl;
use yii\web\Controller;
use yii\web\Response;
use yii\filters\VerbFilter;

class HomeController extends Controller
{
    /**
     * {@inheritdoc}
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout'],
                'rules' => [
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    /**
     * Displays homepage.
     *
     * @return string
     */
    public function actionIndex()
    {
        if (Yii::$app->user->isGuest) {
            return $this->redirect(['site/login']);
        }
        return $this->render('index', [
            'countWorkOrders' => WorkOrders::find()
            ->select(['COUNT(*) AS counter'])
            ->where('is_deleted = 0')
            ->all(),
            'countCustomers' => Customers::find()
            ->select(['COUNT(*) AS counter'])
            ->where('is_deleted = 0')
            ->all(),
        ]);
    }

    /**
     * return logged username.
     *
     * @return string
     */
    public static function getUsername()
    {
        if (Yii::$app->user->id) {
            $user = Users::findIdentity(Yii::$app->user->id);
            if (!$user) return null;
            return $user->username;
        }
        return null;
    }
}
