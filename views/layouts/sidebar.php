<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="/" class="brand-link">
        <img src="<?=$defaultAsset->baseUrl?>/<?=$companyLogo?>" alt="<?=$companyName?> Logo" class="brand-image">
        <span class="brand-text font-weight-light"><?=$companyName?></span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
        <!-- SidebarSearch Form -->
        <!-- href be escaped -->
        <!-- <div class="form-inline">
            <div class="input-group" data-widget="sidebar-search">
                <input class="form-control form-control-sidebar" type="search" placeholder="Search" aria-label="Search">
                <div class="input-group-append">
                    <button class="btn btn-sidebar">
                        <i class="fas fa-search fa-fw"></i>
                    </button>
                </div>
            </div>
        </div> -->

        <!-- Sidebar Menu -->
        <nav class="mt-2">
            <?php
            echo \hail812\adminlte\widgets\Menu::widget([
                'items' => [
                    ['label' => 'Dasbor', 'url' => ['/home/index'], 'icon' => 'tachometer-alt'],
                    ['label' => 'Buat PKB', 'url' => ['/work-orders/create'], 'icon' => 'edit'],
                    ['label' => 'List PKB', 'url' => ['/work-orders/index'], 'icon' => 'book'],
                    ['label' => 'List Pelanggan', 'url' => ['/customers/index'], 'icon' => 'users'],
                    ['label' => 'Jasa', 'url' => ['/services/index'], 'icon' => 'wrench'],
                    ['label' => 'Kategori', 'url' => ['/categories/index'], 'icon' => 'car'],
                    [
                        'label' => 'Manajemen Pengguna',
                        'icon' => 'user',
                        'items' => [
                            ['label' => 'Pengguna', 'url' => ['/users/index'], 'iconStyle' => 'far'],
                            ['label' => 'Hak Akses', 'url' => ['/roles/index'], 'iconStyle' => 'far'],
                        ]
                    ],
                    [
                        'label' => 'Pengaturan',
                        'icon' => 'cog',
                        'items' => [
                            ['label' => 'Umum', 'url' => ['/generals/index'], 'iconStyle' => 'far'],
                        ]
                    ],
                ],
            ]);
            ?>
        </nav>
        <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
</aside>