<?php

use app\models\Roles;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;

/** @var yii\web\View $this */
/** @var app\models\RolesSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Hak Akses';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="index-wrapper">

    <p class="float-right">
        <?php //echo Html::a('Tambah Hak Akses', ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <div class="clearfix"></div>

    <?php echo $this->render('_search', ['model' => $searchModel]); ?>

    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'summary' => 'Menampilkan <b>{begin}-{end}</b> dari <b>{totalCount}</b> data',
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            'name',
            // [
            //     'class' => ActionColumn::className(),
            //     'header' => 'Aksi',
            //     'headerOptions' => ['style' => 'color:#337ab7'],
            //     'template' => '{update}&nbsp;&nbsp;{delete}',
            //     'buttons' => [
            //         'update' => function ($action, Roles $model) {
            //             $url = Url::toRoute([$action]);
            //             return Html::a('Ubah', $url, ['class' => 'btn btn-warning']);
            //         },
            //         'delete' => function ($action, Roles $model) {
            //             $url = Url::toRoute([$action]);
            //             return Html::a('Hapus', $url, [
            //                 'class' => 'btn btn-danger',
            //                 'data' => [
            //                     'confirm' => 'Apakah Anda yakin akan menghapus data ini?',
            //                     'method' => 'post',
            //                 ],
            //             ]);
            //         }
            //     ]
            // ]
        ]
    ]); ?>


</div>
