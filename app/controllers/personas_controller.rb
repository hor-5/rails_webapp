class PersonasController < ApplicationController
  before_action :set_persona, only: %i[ show edit update destroy ]

  # GET /personas or /personas.json
  def index
    #@personas =Persona.all()order('fecha_nac') #Persona.find_by_sql('select * from personas order by month(:fecha_nac)')   
    order= Persona.all()
    order1=order.to_a
    order1.sort!{|a,b| a.fecha_nac.month<=>b.fecha_nac.day}
    @personas = order1 

    aEdades=[]
    suma=0
    @personas.each do |persona|
      edad= Integer( DateTime.now.strftime('%Y')) - Integer(persona.fecha_nac.year)
      aEdades.push(edad)
    end
    for edad in aEdades
      suma+=edad
    end
    @promedio = suma/aEdades.size
  end

  # GET /personas/1 or /personas/1.json
  def show
    @edad = Integer( DateTime.now.strftime('%Y')) - Integer(@persona.fecha_nac.year)
  end

  # GET /personas/new
  def new
    @persona = Persona.new
  end

  # GET /personas/1/edit
  def edit
  end

  # POST /personas or /personas.json
  def create
    @persona = Persona.new(persona_params)

    respond_to do |format|
      if @persona.save
        format.html { redirect_to @persona, notice: "Registro agregado con exito."}
        format.json { render :show, status: :created, location: @persona }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /personas/1 or /personas/1.json
  def update
    respond_to do |format|
      if @persona.update(persona_params)
        format.html { redirect_to @persona, notice: "Registro actualizado con exito." }
        format.json { render :show, status: :ok, location: @persona }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @persona.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /personas/1 or /personas/1.json
  def destroy
    @persona.destroy
    respond_to do |format|
      format.html { redirect_to personas_url, notice: "Se eliminó el registro correctamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_persona
      @persona = Persona.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def persona_params
      params.require(:persona).permit(:dni, :nombre, :apellido, :fecha_nac)
    end


end
