<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\Customers $model */

$this->title = 'Lihat Pelanggan';
$this->params['breadcrumbs'][] = ['label' => 'Pelanggan', 'url' => ['/customers']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="customers-view" id="viewCustomer">

<div class="form-wrapper">

    <?php $form = ActiveForm::begin(); ?>

    <div class="row">
        <div class="col-6">
            <?= $form->field($model, 'license_plate')->textInput(['disabled' => true]) ?>
            <?= $form->field($model, 'name')->textInput(['disabled' => true]) ?>
            <?= $form->field($model, 'phone_number')->textInput(['disabled' => true]) ?>
        </div>
        <div class="col-6">
            <?= $form->field($model, 'category_name')->textInput(['disabled' => true]) ?>
            <?= $form->field($model, 'email')->textInput(['disabled' => true]) ?>
            <?= $form->field($model, 'address')->textArea(['disabled' => true]) ?>
        </div>
    </div>
    <div class="row">
        <div class="col-6">
            <?= $form->field($model, 'year')->textInput(['disabled' => true]) ?>
            <?= $form->field($model, 'kilometre')->textInput(['disabled' => true]) ?>
            <?= $form->field($model, 'vehicle_identification_number')->textInput(['disabled' => true]) ?>
            <?= $form->field($model, 'engine_number')->textInput(['disabled' => true]) ?>
        </div>
        <div class="col-6">
            <?= $form->field($model, 'brand')->textInput(['disabled' => true]) ?>
            <?= $form->field($model, 'type')->textInput(['disabled' => true]) ?>
            <?= $form->field($model, 'color')->textInput(['disabled' => true]) ?>
        </div>
    </div>

    <div class="form-group field-pkb">
        <label class="control-label" for="list-pkb">List PKB</label>
        <table class="table table-bordered">
            <thead>
                <th width="10%">No.</th>
                <th>Nomor PKB</th>
            </thead>
            <tbody>
                <?php $i = 1; foreach ($modelWorkOrders as $row): ?>
                <tr>
                    <td><?= $i ?></td>
                    <td><?= Html::a($row->number, ['/work-orders/view?id=' . $row->id]) ?></td>
                </tr>
                <?php $i++; endforeach; ?>
            </tbody>
        </table>
    </div>

    <div class="form-group">
        <?= Html::a('Kembali', ['index'], ['class' => 'btn btn-warning']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>


</div>