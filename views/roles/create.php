<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Roles $model */

$this->title = 'Tambah Hak Akses';
$this->params['breadcrumbs'][] = ['label' => 'Hak Akses', 'url' => ['/roles']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="roles-create">
    
    <?= $this->render('_form', [
        'model' => $model,
        'new' => true
    ]) ?>

</div>
