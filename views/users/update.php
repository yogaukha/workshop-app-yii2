<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Users $model */

$this->title = 'Ubah Pengguna : ' . $model->username;
$this->params['breadcrumbs'][] = ['label' => 'Pengguna', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->username, 'url' => ['update', 'id' => $model->id]];
$this->params['breadcrumbs'][] = 'Ubah';
?>
<div class="users-update">

    <?= $this->render('_form', [
        'model' => $model,
        'roles' => $roles,
        'new' => false
    ]) ?>

</div>
