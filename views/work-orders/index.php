<?php

use app\models\WorkOrders;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;

/** @var yii\web\View $this */
/** @var app\models\WorkOrdersSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'List PKB';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="index-wrapper">

    <?php echo $this->render('_search', ['model' => $searchModel]); ?>

    <p class="float-right">
        <?php //echo Html::a('Tambah PKB', ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <div class="clearfix"></div>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'summary' => 'Menampilkan <b>{begin}-{end}</b> dari <b>{totalCount}</b> data',
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            'number',
            'customer_license_plate',
            'customer_name',
            [
                'class' => ActionColumn::className(),
                'header' => 'Aksi',
                'headerOptions' => ['style' => 'color:#337ab7'],
                'template' => '{update}&nbsp;&nbsp;{print}',
                // 'template' => '{update}&nbsp;&nbsp;{delete}',
                'buttons' => [
                    'update' => function ($action, WorkOrders $model) {
                        $url = Url::toRoute([$action]);
                        return Html::a('Ubah', $url, ['class' => 'btn btn-warning']);
                    },
                    'print' => function ($action, WorkOrders $model) {
                        $url = Url::toRoute([$action]);
                        return Html::a('Cetak', $url, [
                            'class' => 'btn btn-info',
                            'target' => '_blank'
                        ]);
                    }
                ]
            ]
        ]
    ]); ?>


</div>
