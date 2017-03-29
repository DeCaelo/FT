class CommunesController < ApplicationController

  before_action :ensure_json_request, only: [:index]
  before_action :find_commune, only: [:show, :update]

  rescue_from ::ActionController::ParameterMissing, with: :handle_missing_param

  def index
    @communes = Commune.all
    render json: @communes
  end

  def show
    render json: @commune
  end

  def create
    render body: nil, status: :forbidden
  end

  def update
    @commune.update!(commune_params)
    render body: nil, status: :no_content
  end

  private

  def find_commune
    @commune = Commune.find_by_code_insee(params[:id])
    render body: nil, status: :not_found if @commune.nil?
  end

  def handle_missing_param
    render body: nil, status: :bad_request
  end

  def ensure_json_request
    render body: nil, status: :not_acceptable unless request.format == :json
  end

  def commune_params
    params.require(:commune).permit(:name, :department, :code_insee, :siren, :population)
  end
end
