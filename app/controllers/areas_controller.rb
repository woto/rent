class AreasController < ApplicationController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  def find__id__by__map_id__and__ref
    respond_to do |format|
      format.json do 
        render json: Area.find_by(map_id: params[:map_id], ref: params[:ref])
      end
    end
  end

  # GET /areas
  # GET /areas.json
  def index
    @q = Area.ransack(ransack_params)
    @areas = @q.result
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
  end

  # GET /areas/new
  def new
    @area = Area.new(map_id: params[:map_id], ref: params[:ref])
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        @area.update_spotted_and_dashboard_maps!
        format.html { redirect_to @area, notice: 'Area was successfully created.' }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        @area.update_spotted_and_dashboard_maps!
        format.html { redirect_to @area, notice: 'Area was successfully updated.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to areas_url, notice: 'Area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:map_id, :ref, :title, :square)
    end

    def ransack_params
      params.require(:q).permit! if params[:q]
    end
end
