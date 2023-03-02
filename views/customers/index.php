<?php

use app\models\Customers;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;

/** @var yii\web\View $this */
/** @var app\models\CustomersSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Pelanggan';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="index-wrapper">

    <?php echo $this->render('_search', ['model' => $searchModel]); ?>

    <p class="float-right">
        <?php echo Html::a('Tambah Pelanggan (Buat PKB)', ['/work-orders/create'], ['class' => 'btn btn-success']) ?>
    </p>
    <div class="clearfix"></div>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'summary' => 'Menampilkan <b>{begin}-{end}</b> dari <b>{totalCount}</b> data',
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            'license_plate',
            'name',
            'brand',
            'type',
            'category_name',
            [
                'class' => ActionColumn::className(),
                'header' => 'Aksi',
                'headerOptions' => ['style' => 'color:#337ab7'],
                'template' => '{view}',
                'buttons' => [
                    'view' => function ($action, Customers $model) {
                        $url = Url::toRoute([$action]);
                        return Html::a('Lihat', $url, ['class' => 'btn btn-info']);
                    }
                ]
            ]
        ]
    ]); ?>


</div>
