<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\jui\DatePicker;
use wbraganca\dynamicform\DynamicFormWidget;
use kartik\select2\Select2

/** @var yii\web\View $this */
/** @var app\models\Users $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="form-wrapper">

    <?php $form = ActiveForm::begin(['id' => 'dynamic-form']); ?>

    <div class="row">
        <div class="col-6">
            <?= $form->field($model, 'number')->textInput(['maxlength' => true, 'readonly' => true]) ?>
            <?= $form->field($model, 'status')->textInput(['maxlength' => true, 'readonly' => true]) ?>
        </div>
        <div class="col-6">
            <?= $form->field($model, 'entry_date')->textInput(['readonly' => true]) ?>
            <?= $form->field($model, 'completion_date')->widget(DatePicker::classname(), [
                'dateFormat' => 'dd-MM-yyyy'
            ]) ?>
        </div>
    </div>
    <div class="card card-default">
        <div class="card-header"><b>Data Pelanggan</b></div>
        <div class="card-body">
            <div class="row">
                <div class="col-6">
                    <?= $form->field($modelCustomer, 'license_plate')->textInput(['maxlength' => true]) ?>
                    <?= $form->field($modelCustomer, 'address')->textArea() ?>
                </div>
                <div class="col-6">
                    <?= $form->field($modelCustomer, 'name')->textInput(['maxlength' => true]) ?>
                    <?= $form->field($modelCustomer, 'email')->textInput(['maxlength' => true]) ?>
                    <?= $form->field($modelCustomer, 'phone_number')->textInput(['maxlength' => true]) ?>
                </div>
            </div>
            <br>
            <p><b>Data Mobil</b></p>
            <hr style="width: 104.3%; margin-left: -20px;">
            <div class="row">
                <div class="col-6">
                    <?= $form->field($modelCustomer, 'category_id')->dropDownList($categories, ['prompt' => 'Pilih Kategori']); ?>
                    <?= $form->field($modelCustomer, 'kilometre')->textInput(['maxlength' => true]) ?>
                    <?= $form->field($modelCustomer, 'vehicle_identification_number')->textInput(['maxlength' => true]) ?>
                    <?= $form->field($modelCustomer, 'engine_number')->textInput(['maxlength' => true]) ?>
                </div>
                <div class="col-6">
                    <?= $form->field($modelCustomer, 'year')->textInput(['maxlength' => true]) ?>
                    <?= $form->field($modelCustomer, 'brand')->textInput(['maxlength' => true]) ?>
                    <?= $form->field($modelCustomer, 'type')->textInput(['maxlength' => true]) ?>
                    <?= $form->field($modelCustomer, 'color')->textInput(['maxlength' => true]) ?>
                </div>
            </div>
        </div>
    </div>

    <div class="card card-default">
        <div class="card-header"><b>Jasa Perbaikan</b></div>
        <div class="card-body">
            <?php DynamicFormWidget::begin([
                'widgetContainer' => 'dynamicform_wrapper', // required: only alphanumeric characters plus "_" [A-Za-z0-9_]
                'widgetBody' => '.container-items', // required: css class selector
                'widgetItem' => '.item', // required: css class
                'limit' => 999, // the maximum times, an element can be cloned (default 999)
                'min' => 0, // 0 or 1 (default 1)
                'insertButton' => '.add-item', // css class
                'deleteButton' => '.remove-item', // css class
                'model' => $modelDetailService[0],
                'formId' => 'dynamic-form',
                'formFields' => [
                    'service_id',
                    'manual_price',
                    'manual_discount',
                    'subtotal',
                ],
            ]); ?>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <button type="button" class="float-right add-item btn btn-success btn-sm"><i class="fa fa-plus"></i> Tambah Jasa Perbaikan</button>
                    <div class="clearfix"></div>
                </div>
                <div class="panel-body container-items"><!-- widgetContainer -->
                    <?php foreach ($modelDetailService as $index => $row): ?>
                        <div class="item panel panel-default"><!-- widgetBody -->
                            <div class="panel-heading">
                                <br>
                                <button type="button" class="float-right remove-item btn btn-danger btn-xs"><i class="fa fa-minus"></i></button>
                                <div class="clearfix"></div>
                            </div>
                            <div class="panel-body">
                                <?php
                                    // necessary for update action.
                                    if (!$row->isNewRecord) {
                                        echo Html::activeHiddenInput($row, "[{$index}]id");
                                    }
                                ?>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <?= $form->field($row, "[{$index}]service_id")->widget(Select2::classname(), [
                                            'data' => $services,
                                            'options' => ['placeholder' => 'Pilih Jasa Perbaikan ...'],
                                            'pluginOptions' => [
                                                'allowClear' => true
                                            ],
                                        ]); ?>
                                    </div>
                                    <div class="col-sm-2">
                                        <?= $form->field($row, "[{$index}]manual_price")->textInput(['maxlength' => true, 'class' => 'form-control service-manual-price']) ?>
                                    </div>
                                    <div class="col-sm-2">
                                        <?= $form->field($row, "[{$index}]manual_discount")->textInput(['maxlength' => true, 'class' => 'form-control service-manual-discount']) ?>
                                    </div>
                                    <div class="col-sm-2">
                                        <?= $form->field($row, "[{$index}]subtotal")->textInput(['maxlength' => true, 'readonly' => true, 'class' => 'form-control service-subtotal']) ?>
                                    </div>
                                </div><!-- end:row -->
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php DynamicFormWidget::end(); ?>
        </div>
        <div class="card-footer">
            <div class="row" style="height: 40px; line-height: 40px;">
                <div class="col-8"></div>
                <div class="col-2">
                    <b>Total Jasa Perbaikan</b>
                </div>
                <div class="col-2">
                    <?= $form->field($model, 'total_service')->textInput(['readonly' => true])->label(false) ?>
                </div>
            </div>
        </div>
    </div>

    <div class="card card-default">
        <div class="card-header"><b>Jasa Sparepart</b></div>
        <div class="card-body">
            <?php DynamicFormWidget::begin([
                'widgetContainer' => 'dynamicform_wrapper_sparepart', // required: only alphanumeric characters plus "_" [A-Za-z0-9_]
                'widgetBody' => '.container-items-sparepart', // required: css class selector
                'widgetItem' => '.item-sparepart', // required: css class
                'limit' => 999, // the maximum times, an element can be cloned (default 999)
                'min' => 0, // 0 or 1 (default 1)
                'insertButton' => '.add-item-sparepart', // css class
                'deleteButton' => '.remove-item-sparepart', // css class
                'model' => $modelDetailSparepart[0],
                'formId' => 'dynamic-form',
                'formFields' => [
                    'sparepart_id',
                    'manual_price',
                    'manual_discount',
                    'subtotal',
                ],
            ]); ?>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <button type="button" class="float-right add-item-sparepart btn btn-success btn-sm"><i class="fa fa-plus"></i> Tambah Sparepart</button>
                    <div class="clearfix"></div>
                </div>
                <div class="panel-body container-items-sparepart"><!-- widgetContainer -->
                    <?php foreach ($modelDetailSparepart as $index => $row): ?>
                        <div class="item-sparepart panel panel-default"><!-- widgetBody -->
                            <div class="panel-heading">
                                <br>
                                <button type="button" class="float-right remove-item-sparepart btn btn-danger btn-xs"><i class="fa fa-minus"></i></button>
                                <div class="clearfix"></div>
                            </div>
                            <div class="panel-body">
                                <?php
                                    // necessary for update action.
                                    if (!$row->isNewRecord) {
                                        echo Html::activeHiddenInput($row, "[{$index}]id");
                                    }
                                ?>
                                <div class="row">
                                    <div class="col-sm-6">
                                        <?= $form->field($row, "[{$index}]sparepart_id")->textInput(['maxlength' => true]) ?>
                                    </div>
                                    <div class="col-sm-2">
                                        <?= $form->field($row, "[{$index}]manual_price")->textInput(['maxlength' => true, 'class' => 'form-control sparepart-manual-price']) ?>
                                    </div>
                                    <div class="col-sm-2">
                                        <?= $form->field($row, "[{$index}]manual_discount")->textInput(['maxlength' => true, 'class' => 'form-control sparepart-manual-discount']) ?>
                                    </div>
                                    <div class="col-sm-2">
                                        <?= $form->field($row, "[{$index}]subtotal")->textInput(['maxlength' => true, 'readonly' => true, 'class' => 'form-control sparepart-subtotal']) ?>
                                    </div>
                                </div><!-- end:row -->
                            </div>
                        </div>
                    <?php endforeach; ?>
                </div>
            </div>
            <?php DynamicFormWidget::end(); ?>
        </div>
        <div class="card-footer">
            <div class="row" style="height: 40px; line-height: 40px;">
                <div class="col-8"></div>
                <div class="col-2">
                    <b>Total Jasa Sparepart</b>
                </div>
                <div class="col-2">
                    <?= $form->field($model, 'total_sparepart')->textInput(['readonly' => true])->label(false) ?>
                </div>
            </div>
        </div>
    </div>
    
    <div class="card card-default">
        <div class="card-footer">
            <div class="row" style="height: 40px; line-height: 40px;">
                <div class="col-8"></div>
                <div class="col-2">
                    <b>Total Keseluruhan</b>
                </div>
                <div class="col-2">
                    <?= $form->field($model, 'grand_total')->textInput(['readonly' => true])->label(false) ?>
                </div>
            </div>
        </div>
    </div>
    
    <div class="card card-default" style="display: none;">
        <div class="card-header"><b>Keluhan Pelanggan</b></div>
        <div class="card-body">
            <div class="row">
                <div class="col-12">
                    <?= $form->field($model, 'customer_complaints')->textArea()->label(false) ?>
                </div>
            </div>
        </div>
    </div>

    <div class="form-group">
        <?= !$new ? Html::a('Kembali', ['index'], ['class' => 'btn btn-warning']) : '' ?>
        <?= $new ? Html::submitButton('Simpan', ['class' => 'btn btn-success']) : Html::submitButton('Ubah', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
