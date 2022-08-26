class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order# 注文商品から注文テーブルの呼び出し
    @order_detail.update(order_detail_params)

    if @order_detail.making_status == "making"
      @order.update(status: "creating")

    elsif @order.order_details.count == @order.order_details.where(making_status: "making_complete").count
      @order.update(status: "preparing")     # 「注文商品の個数」、「making_statusが「製作終了」の商品数」カウント
                                              #同じ場合注文ステータスを「発送準備中」に"自動更新"
    end

  redirect_to admin_order_path(@order_detail.order)
  end

  private
    def order_detail_params
      params.require(:order_detail).permit(:making_status)
    end

end
