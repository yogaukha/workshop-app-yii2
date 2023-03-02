<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/** @var yii\web\View $this */
/** @var app\models\Generals $model */
/** @var yii\widgets\ActiveForm $form */
$items = ['Teks' => 'Teks', 'Gambar' => 'Gambar'];
?>

<div class="form-wrapper">

    <?php $form = ActiveForm::begin(['options' => ['enctype' => 'multipart/form-data']]); ?>

    <?= $form->field($model, 'type')->radioList($items); ?>
    <?= $form->field($model, 'name')->textInput(['maxlength' => true, 'readonly' => true]) ?>
    <?= $form->field($model, 'value')->textInput(['maxlength' => true]) ?>
    <div class="form-group" id="image-wrapper-general">
        <img src="<?php echo '/' . $model->value; ?>" width="120">
    </div>
    <?= $form->field($model, 'image')->fileInput(['accept' => 'image/png']) ?>

    <div class="form-group">
        <?= Html::a('Kembali', ['index'], ['class' => 'btn btn-warning']) ?>
        <?= $new ? Html::submitButton('Simpan', ['class' => 'btn btn-success']) : Html::submitButton('Ubah', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
