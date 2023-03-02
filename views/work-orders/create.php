<?php

use yii\helpers\Html;

/** @var yii\web\View $this */
/** @var app\models\Services $model */

$this->title = 'Buat PKB Baru';
$this->params['breadcrumbs'][] = ['label' => 'Buat PKB Baru'];
// $this->params['breadcrumbs'][] = $this->title;
?>
<div class="services-create" id="createService">
    
    <?= $this->render('_form', [
        'model' => $model,
        'modelDetailService' => $modelDetailService,
        'modelDetailSparepart' => $modelDetailSparepart,
        'modelCustomer' => $modelCustomer,
        'categories' => $categories,
        'services' => $services,
        'new' => true
    ]) ?>

</div>