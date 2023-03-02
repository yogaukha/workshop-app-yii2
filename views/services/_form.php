<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\Users $model */
/** @var yii\widgets\ActiveForm $form */
?>

<div class="form-wrapper">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'name')->textInput(['maxlength' => true]) ?>
    <div class="form-group field-service-detail-price">
        <label class="control-label" for="services-name">Harga</label>

        <table class="table table-bordered">
            <thead>
                <tr>
                    <?php foreach ($modelCategory as $category) {
                        echo '<th class="text-center">Tipe ' . $category->name . '</th>';
                    }
                    ?>
                </tr>
                <tr>
                    <?php
                        $i = 0;
                        // if ($new) {
                        //     foreach ($modelCategory as $category) {
                        //         echo '<td>' . 
                        //             Html::hiddenInput('ServicePrices['. $i .'][category_id]', $category->id) .
                        //             Html::input('text', 'ServicePrices['. $i .'][price]', '', $options=['class' => 'form-control', 'maxlength' => 100, 'placeholder' => 'Harga (angka saja) ... ']) .
                        //         '</td>';
                        //         $i++;
                        //     }
                        // } else {
                        if (is_array($modelServicePrices)) {
                            foreach ($modelServicePrices as $servicePrices) {
                                echo '<td>' . 
                                    Html::hiddenInput('ServicePrices['. $i .'][category_id]', $servicePrices->category_id) .
                                    Html::input('text', 'ServicePrices['. $i .'][price]', $servicePrices->price, $options=['class' => 'form-control', 'maxlength' => 100, 'placeholder' => 'Harga (angka saja) ... ']) .
                                '</td>';
                                $i++;
                            }
                        } else {
                            foreach ($modelCategory as $category) {
                                echo '<td>' . 
                                    Html::hiddenInput('ServicePrices['. $i .'][category_id]', $category->id) .
                                    Html::input('text', 'ServicePrices['. $i .'][price]', '', $options=['class' => 'form-control', 'maxlength' => 100, 'placeholder' => 'Harga (angka saja) ... ']) .
                                '</td>';
                                $i++;
                            }
                        }
                        // }
                    ?>
                </tr>
            </thead>
            <tbody></tbody>
        </table>
    </div>
    <?php /*
        echo $form->field($model, 'role_id')->dropDownList(
        $roles,
        ['prompt' => 'Pilih Hak Akses']
        );
        */
    ?>

    <div class="form-group">
        <?= Html::a('Kembali', ['index'], ['class' => 'btn btn-warning']) ?>
        <?= $new ? Html::submitButton('Simpan', ['class' => 'btn btn-success']) : Html::submitButton('Ubah', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
