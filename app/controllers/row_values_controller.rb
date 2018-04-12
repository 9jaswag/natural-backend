# Copyright (C) Manuel Arno Korfmann - All Rights Reserved
# Unauthorized copying of this file, or parts of this file, via any medium is strictly prohibited
# Proprietary and confidential
# Written by Manuel Arno Korfmann <manu@korfmann.info>, April 2018

class RowValuesController < ApplicationController
  before_action :set_row_value, only: [:show, :update, :destroy]

  # GET /row_values
  def index
    @row_values = RowValue.all

    render json: @row_values
  end

  # GET /row_values/1
  def show
    render json: @row_value
  end

  # POST /row_values
  def create
    @row_value = RowValue.new(row_value_params)

    if @row_value.save
      render json: @row_value, status: :created, location: @row_value
    else
      render json: @row_value.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /row_values/1
  def update
    if @row_value.update(row_value_params)
      render json: @row_value
    else
      render json: @row_value.errors, status: :unprocessable_entity
    end
  end

  # DELETE /row_values/1
  def destroy
    @row_value.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_row_value
      @row_value = RowValue.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def row_value_params
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:column, :row, :value])
    end
end
