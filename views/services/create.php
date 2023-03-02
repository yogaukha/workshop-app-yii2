<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Services $model */

$this->title = 'Tambah Jasa';
$this->params['breadcrumbs'][] = ['label' => 'Jasa', 'url' => ['/services']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="services-create" id="createService">
    
    <?= $this->render('_form', [
        'model' => $model,
        'modelCategory' => $modelCategory,
        'modelServicePrices' => $modelServicePrices,
        'new' => true
    ]) ?>

</div>