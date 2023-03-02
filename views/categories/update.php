<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Categories $model */

$this->title = 'Ubah Kategori : ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Kategori', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['update', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Ubah';
?>
<div class="categories-update">

    <?= $this->render('_form', [
        'model' => $model,
        'new' => false
    ]) ?>

</div>
