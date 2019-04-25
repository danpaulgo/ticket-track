class TransactionSourcesController < ApplicationController
  before_action :set_object, only: [:show, :edit, :update, :destroy]

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
      redirect_to @transaction_source, notice: 'Transaction source was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /transaction_sources/1
  # DELETE /transaction_sources/1.json
  def destroy
    @transaction_source.destroy
    redirect_to transaction_sources_url, notice: 'Transaction source was successfully destroyed.'
  end

  private

end
