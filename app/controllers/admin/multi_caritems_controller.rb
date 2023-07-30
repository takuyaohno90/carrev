class Admin::MultiCaritemsController < ApplicationController
  def new
    @caritem = CarItem.new
  end

  def create
    @caritem = CarItem.new(caritem_params)

    # if @caritem.save
    @caritem.save

      # ファイルがアップロードされているかを確認
      if params[:car_item][:excel_file].present?

        # アップロードされたエクセルファイルを取得
        excel_file = params[:car_item][:excel_file].tempfile

        # rooを使用してエクセルファイルを解析
        workbook = Roo::Spreadsheet.open(excel_file)
        sheet = workbook.sheet(0) # シート1を使用する場合

        # エクセルファイルの各行を処理
        sheet.each_row_streaming(offset: 1) do |row|
          maker_id = row[0].value.to_i
          fuel_id = row[1].value.to_i
          bodytype_id = row[2].value.to_i
          name = row[3].value.to_s.strip
          num_people = row[4].value.to_s.strip
          displacement = row[5].value.to_s.strip
          drive_system = row[6].value.to_s.strip
          door = row[7].value.to_s.strip
          mission = row[8].value.to_s.strip
          model_year = row[9].value.to_s.strip
          fuel_consumption = row[10].value.to_s.strip
          weight = row[11].value.to_s.strip
          size = row[12].value.to_s.strip

          # タイトルと著者が空でない場合のみデータベースに登録
          # if title.present? && author.present?
            CarItem.create(maker_id: maker_id, fuel_id: fuel_id, bodytype_id: bodytype_id, name: name, num_people: num_people, displacement: displacement, drive_system: drive_system, door: door, mission: mission, model_year: model_year, fuel_consumption: fuel_consumption, weight: weight, size: size)
          # end
        end
      end

      @caritems = CarItem.all
      redirect_to admin_path, notice: "caritem was successfully uploaded."
    # else
      # render :new
    # end
  end

  private

  def caritem_params
    params.require(:car_item).permit(:maker_id, :fuel_id, :bodytype_id, :name, :num_people, :displacement, :drive_system, :door, :mission, :model_year, :fuel_consumption, :weight, :size)
  end
end