<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Roles $model */

$this->title = 'Ubah Hak Akses : ' . $model->name;
$this->params['breadcrumbs'][] = ['label' => 'Hak Akses', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->name, 'url' => ['update', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Ubah';
?>
<div class="roles-update">

    <?= $this->render('_form', [
        'model' => $model,
        'new' => false
    ]) ?>

</div>
