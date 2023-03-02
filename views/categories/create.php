<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Categories $model */

$this->title = 'Tambah Kategori';
$this->params['breadcrumbs'][] = ['label' => 'Kategori', 'url' => ['/categories']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="categories-create">
    
    <?= $this->render('_form', [
        'model' => $model,
        'new' => true
    ]) ?>

</div>
