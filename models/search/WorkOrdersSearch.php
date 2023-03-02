<?php

namespace app\models\search;

use yii\base\Model;
use yii\data\ActiveDataProvider;
use app\models\WorkOrders;

/**
 * WorkOrdersSearch represents the model behind the search form of `app\models\WorkOrders`.
 */
class WorkOrdersSearch extends WorkOrders
{
    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['number', 'customer_name', 'customer_license_plate'], 'safe']
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = WorkOrders::find()
                ->select(['work_orders.*', 'customers.name as customer_name', 'customers.license_plate as customer_license_plate'])
                ->innerJoin('customers', '`customers`.`id` = `work_orders`.`customer_id`')
                ->where(['=', 'work_orders.is_deleted', '0'])
                ->andWhere(['=', 'customers.is_deleted', '0'])
                ;

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
            'sort' => ['defaultOrder' => ['createdtime' => SORT_DESC]]
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        $query->andFilterWhere(['like', 'number', $this->number])
                ->andFilterWhere(['like', 'customers.name', $this->customer_name])
                ->andFilterWhere(['like', 'customers.license_plate', $this->customer_license_plate])
        ;

        return $dataProvider;
    }
}
