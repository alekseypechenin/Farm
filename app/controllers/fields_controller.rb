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

  ## Start Default action

  # GET /fields
  # GET /fields.xml
  def start
    respond_to do |format|
      format.html # start.html.erb
    end
  end

  ## Actions for admin page
  ## For using this actions we should madify reures.rb

  # GET /fields
  # GET /fields.xml
  def index
    @fields = Field.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fields }
    end
  end

  # GET /fields/1
  # GET /fields/1.xml
  def show
    @field = Field.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @field }
    end
  end

  # GET /fields/new
  # GET /fields/new.xml
  def new
    @field = Field.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @field }
    end
  end

  # GET /fields/1/edit
  def edit
    @field = Field.find(params[:id])
  end

  # POST /fields
  # POST /fields.xml
  def create
    @field = Field.new(params[:field])

    respond_to do |format|
      if @field.save
        format.html { redirect_to(@field, :notice => 'Field was successfully created.') }
        format.xml  { render :xml => @field, :status => :created, :location => @field }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @field.errors, :status => :unprocessable_entity }
      end
    end
  end

 

 
  
  # DELETE /fields/1
  # DELETE /fields/1.xml
  def destroy
    @field = Field.find(params[:id])
    @field.destroy

    respond_to do |format|
      format.html { redirect_to(fields_url) }
      format.xml  { head :ok }
    end
  end
end