<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Generals $model */

$this->title = 'Ubah Pengaturan Umum : ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Pengaturan Umum', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['update', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Ubah';
?>
<div class="generals-update">

    <?= $this->render('_form', [
        'model' => $model,
        'new' => false
    ]) ?>

</div>
