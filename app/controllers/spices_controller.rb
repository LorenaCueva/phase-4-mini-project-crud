class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_response

def index
    spices = Spice.all 
    render json: spices
end

def create
    spice = Spice.create!(spices_params)
    render json: spice, status: :created
end

def update
    spice = find_spice
    spice.update!(spices_params)
    render json: spice, status: :ok
end

def destroy
    spice = find_spice
    spice.destroy
    head :no_content
end


private


def spices_params
    params.permit(:title, :image, :description, :notes, :rating)
end

def record_not_found_response
    render json: {error: "Record not found"}, status: :not_found
end

def record_invalid_response
    render json: {error: "Record Invalid"}, status: :unprocessable_entity
end

def find_spice
    @spice = Spice.find(params[:id])
end

end
