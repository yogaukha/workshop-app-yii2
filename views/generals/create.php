<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Generals $model */

$this->title = 'Tambah Pengaturan Umum';
$this->params['breadcrumbs'][] = ['label' => 'Pengaturan Umum', 'url' => ['/generals']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="generals-create">
    
    <?= $this->render('_form', [
        'model' => $model,
        'new' => true
    ]) ?>

</div>
