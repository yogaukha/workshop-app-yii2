<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Services $model */

$this->title = 'Ubah Jasa : ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Jasa', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['update', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Ubah';
?>
<div class="services-update">

    <?= $this->render('_form', [
        'model' => $model,
        'modelCategory' => $modelCategory,
        'modelServicePrices' => $modelServicePrices,
        'new' => false
    ]) ?>

</div>
