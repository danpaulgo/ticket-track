class TransactionSourcesController < ApplicationController
  
  before_action :logged_out_redirect, :inactive_redirect, :non_admin_redirect
  before_action :set_object, :nil_object_redirect, only: [:edit, :update, :destroy]

  # GET /transaction_sources
  # GET /transaction_sources.json
  def index
    @transaction_sources = TransactionSource.all
    .order(name: :asc)
    .paginate(page: params[:page], per_page: 20)
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
