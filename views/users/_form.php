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
    <?= $form->field($model, 'username')->textInput(['maxlength' => true]) ?>
    <?php echo $new ? $form->field($model, 'password')->passwordInput() : $form->field($model, 'password')->passwordInput()->hint('Kosongkan jika tidak ingin mengubah password') ?>
    <?= $form->field($model, 'email')->textInput() ?>
    <?= $form->field($model, 'role_id')->dropDownList(
        $roles,
        ['prompt' => 'Pilih Hak Akses']
        );
    ?>

    <div class="form-group">
        <?= Html::a('Kembali', ['index'], ['class' => 'btn btn-warning']) ?>
        <?= $new ? Html::submitButton('Simpan', ['class' => 'btn btn-success']) : Html::submitButton('Ubah', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
