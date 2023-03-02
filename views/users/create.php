<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Users $model */

$this->title = 'Tambah Pengguna';
$this->params['breadcrumbs'][] = ['label' => 'Pengguna', 'url' => ['/users']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="users-create" id="createUser">
    
    <?= $this->render('_form', [
        'model' => $model,
        'roles' => $roles,
        'new' => true
    ]) ?>

</div>