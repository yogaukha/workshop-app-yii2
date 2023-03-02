<?php

use app\models\Categories;
use yii\helpers\Html;
use yii\helpers\Url;
use yii\grid\ActionColumn;
use yii\grid\GridView;

/** @var yii\web\View $this */
/** @var app\models\CategoriesSearch $searchModel */
/** @var yii\data\ActiveDataProvider $dataProvider */

$this->title = 'Kategori';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="index-wrapper">
    
    <?php echo $this->render('_search', ['model' => $searchModel]); ?>

    <p class="float-right">
        <?= Html::a('Tambah Kategori', ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <div class="clearfix"></div>


    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'summary' => 'Menampilkan <b>{begin}-{end}</b> dari <b>{totalCount}</b> data',
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],
            'name',
            'remark:ntext',
            [
                'class' => ActionColumn::className(),
                'header' => 'Aksi',
                'headerOptions' => ['style' => 'color:#337ab7'],
                'template' => '{update}&nbsp;&nbsp;{delete}',
                'buttons' => [
                    'update' => function ($action, Categories $model) {
                        $url = Url::toRoute([$action]);
                        return Html::a('Ubah', $url, ['class' => 'btn btn-warning']);
                    },
                    'delete' => function ($action, Categories $model) {
                        $url = Url::toRoute([$action]);
                        return Html::a('Hapus', $url, [
                            'class' => 'btn btn-danger',
                            'data' => [
                                'confirm' => 'Apakah Anda yakin akan menghapus data ini?',
                                'method' => 'post',
                            ],
                        ]);
                    }
                ]
            ]
        ]
    ]); ?>


</div>
