class FieldsController < ApplicationController

  ############ Flex actions ##############

  # GET /fields
  # GET /fields.xml
  def indextoclient
    @fields = Field.all
    render :xml => @fields
  end

  # POST /fields
  # POST /fields/.xml/createtoserver params
  def createtoserver
    @field = Field.new(ftype: params[:ftype],
                       fstate: 1,
                       x: params[:x],
                       y: params[:y])
    if @field.save
      render :xml => @field
    else
      render :xml => @field.errors
    end
  end

   # POST /fields
  # POST /fields/growallfields

  def growallfields
    @fields = Field.all
    @fields.each { |field|
        if (field.fstate != 5) then
          field.fstate = field.fstate + 1
          field.update_attribute(:fstate, field.fstate)
        end
      }
    render :xml => @fields
  end

  # POST /fields
  # POST /fields.xml
  def takefield
    @field = Field.find(params[:id])
    if @field.fstate == 5 then
     @field.destroy
    end
    @fields = Field.all
    render :xml => @fields
  end

  # PUT /fields/1
  # PUT /fields/update :params
  def update
    @field = Field.find(params[:id])
    if @field.update_attributes(x: params[:x],y: params[:y])
       render :xml => @field
     else
       render :xml => @field.errors
    end
  end

  ############ Flex actions ##############

end