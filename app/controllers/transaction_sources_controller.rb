class TransactionSourcesController < ApplicationController
  
  before_action :valid_admin
  before_action :set_object, only: [:edit, :update, :destroy]

  # GET /transaction_sources
  # GET /transaction_sources.json
  def index
    @transaction_sources = TransactionSource.all
  end

  # GET /transaction_sources/1/edit
  def edit

  end

  # PATCH/PUT /transaction_sources/1
  # PATCH/PUT /transaction_sources/1.json
  def update
    if @transaction_source.update(object_params)
      flash[:notice] = "Transaction source was successfully updated"
      redirect_to transaction_sources_path
    else
      render :edit
    end
  end

  # DELETE /transaction_sources/1
  # DELETE /transaction_sources/1.json
  def destroy
    @transaction_source.destroy
    flash[:notice] = "Transaction source was successfully deleted"
    redirect_to transaction_sources_url
  end

  private

end
