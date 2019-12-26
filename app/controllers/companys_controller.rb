class CompanysController < ApplicationController
      def index
        company = Company.all()
	render json: {status: 'SUCCESS', data: company}, status: :ok
      end

      def show
        company = Company.find(params[:id]);
        render json: {status: 'SUCCESS', data: company}, status: :ok
      end

      def create
        company = Company.new(company_params)
        
        if company.save
          render json: {status: 'SUCCESS', data: company}, status: :ok
        else
          render json: {status: 'ERROR', data: company.errors}, status: :unprocessable_entity
        end
      end

      private

      def company_params
        params.permit(:name)
      end
end

