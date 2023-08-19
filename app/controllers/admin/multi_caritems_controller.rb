class Admin::MultiCaritemsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @caritem = CarItem.new
  end

  def create
    # ファイルがアップロードされているかを確認
    if params[:car_item][:excel_file].present?
      # アップロードされたエクセルファイルを取得
      excel_file = params[:car_item][:excel_file].tempfile

      # rooを使用してエクセルファイルを解析
      workbook = Roo::Spreadsheet.open(excel_file)
      sheet = workbook.sheet(0) # シート1を使用する場合

      # エクセルファイルの各行を処理
      sheet.each_row_streaming(offset: 1) do |row|
      @caritem = CarItem.new
      @caritem.maker_id = row[0].value.to_i
      @caritem.fuel_id = row[1].value.to_i
      @caritem.bodytype_id = row[2].value.to_i
      @caritem.name = row[3].value.to_s.strip
      @caritem.num_people = row[4].value.to_s.strip
      @caritem.displacement = row[5].value.to_s.strip
      @caritem.drive_system = row[6].value.to_s.strip
      @caritem.door = row[7].value.to_s.strip
      @caritem.mission = row[8].value.to_s.strip
      @caritem.model_year = row[9].value.to_s.strip
      @caritem.fuel_consumption = row[10].value.to_s.strip
      @caritem.weight = row[11].value.to_s.strip
      @caritem.size = row[12].value.to_s.strip

        # 同じ登録車種があるかチェック
        @caritem_check = CarItem.find_by(name: @caritem.name)
        if !@caritem_check
         if @caritem.save
         else
           puts @caritem.errors.full_messages
         end
        end
      end

    @caritems = CarItem.all
    redirect_to admin_path, notice: "caritem was successfully uploaded."
    else
      render :new
    end
  end

  private

  def caritem_params
    params.require(:car_item).permit(:maker_id, :fuel_id, :bodytype_id, :name, :num_people, :displacement, :drive_system, :door, :mission, :model_year, :fuel_consumption, :weight, :size)
  end
end