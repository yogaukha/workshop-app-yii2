<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Services $model */

$this->title = 'Ubah PKB : ' . $model->number;
$this->params['breadcrumbs'][] = ['label' => 'List PKB', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->number, 'url' => ['update', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Ubah';
?>
<div class="services-update">

    <?= $this->render('_form', [
        'model' => $model,
        'modelDetailService' => $modelDetailService,
        'modelDetailSparepart' => $modelDetailSparepart,
        'modelCustomer' => $modelCustomer,
        'categories' => $categories,
        'services' => $services,
        'new' => false
    ]) ?>

</div>
