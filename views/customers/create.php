<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Customers $model */

$this->title = 'Tambah Pelanggan';
$this->params['breadcrumbs'][] = ['label' => 'Pelanggan', 'url' => ['/customers']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="customers-create" id="createCustomer">
    
    <?= $this->render('_form', [
        'model' => $model,
        'modelCategory' => $modelCategory,
        'new' => true
    ]) ?>

</div>