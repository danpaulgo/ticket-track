class TransactionSourcesController < ApplicationController
  before_action :set_transaction_source, only: [:show, :edit, :update, :destroy]

  # GET /transaction_sources
  # GET /transaction_sources.json
  def index
    @transaction_sources = TransactionSource.all
  end

  # GET /transaction_sources/1
  # GET /transaction_sources/1.json
  def show
  end

  # GET /transaction_sources/new
  def new
    @transaction_source = TransactionSource.new
  end

  # GET /transaction_sources/1/edit
  def edit
  end

  # POST /transaction_sources
  # POST /transaction_sources.json
  def create
    @transaction_source = TransactionSource.new(transaction_source_params)

    respond_to do |format|
      if @transaction_source.save
        format.html { redirect_to @transaction_source, notice: 'Transaction source was successfully created.' }
        format.json { render :show, status: :created, location: @transaction_source }
      else
        format.html { render :new }
        format.json { render json: @transaction_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transaction_sources/1
  # PATCH/PUT /transaction_sources/1.json
  def update
    respond_to do |format|
      if @transaction_source.update(transaction_source_params)
        format.html { redirect_to @transaction_source, notice: 'Transaction source was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction_source }
      else
        format.html { render :edit }
        format.json { render json: @transaction_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_sources/1
  # DELETE /transaction_sources/1.json
  def destroy
    @transaction_source.destroy
    respond_to do |format|
      format.html { redirect_to transaction_sources_url, notice: 'Transaction source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction_source
      @transaction_source = TransactionSource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_source_params
      params.fetch(:transaction_source, {})
    end
end
