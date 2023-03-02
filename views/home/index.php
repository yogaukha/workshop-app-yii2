<?php
$this->title = 'Selamat Datang';
$this->params['breadcrumbs'] = [['label' => 'Dasbor']];
?>
<div class="container-fluid">
    <div class="row">
        <div class="col-lg-4 col-md-6 col-sm-6 col-12">
            <?= \hail812\adminlte\widgets\SmallBox::widget([
                'title' => $countWorkOrders[0]->counter,
                'text' => 'Total PKB',
                'icon' => 'fas fa-wrench',
                'linkText' => 'Cek disini',
                'linkUrl' => '/work-orders/index',
            ]) ?>
        </div>
        <div class="col-lg-4 col-md-6 col-sm-6 col-12">
            <?= \hail812\adminlte\widgets\SmallBox::widget([
                'title' => $countCustomers[0]->counter,
                'text' => 'Total Pelanggan',
                'icon' => 'fas fa-user-plus',
                'theme' => 'gradient-success',
                'linkText' => 'Cek disini',
                'linkUrl' => '/customers/index',
            ]) ?>
        </div>
    </div>
</div>