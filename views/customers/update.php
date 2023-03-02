<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Customers $model */

$this->title = 'Ubah Pelanggan : ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Pelanggan', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['update', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Ubah';
?>
<div class="customers-update">

    <?= $this->render('_form', [
        'model' => $model,
        'modelCategory' => $modelCategory,
        'new' => false
    ]) ?>

</div>
