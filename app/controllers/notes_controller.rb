class NotesController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    before_action :set_note, only: %w[show edit update destroy]
    
    def index
       @notes = Note.all
    end
    
    def show
    end
    
    def new
        @note = Note.new
    end
    
    def create
       respond_to do |format|
            @note = Note.new(notes_params)
            if @note.save 
                format.html{ redirect_to @note, notice: "Note has been created successfully!"}
            else
                format.html {render :new , status: :unprocessable_entity}    
            end
       end
    end
    
    def edit
    end
    
    def update
        respond_to do |format|
            if @note.update(notes_params)
               format.html { redirect_to note_url(@note), notice: "Note has been updated" }
            else
                format.html { render :edit, status: :unprocessable_entity}  
            end
        end
    end
    
    
    def destroy
       respond_to do |format|
          if @note.destroy
             format.html { redirect_to notes_path, notice: "Note has been deleted successfully"} 
          else
              format.html { redirect_to notes_path, status: :unprocessable_entitys}
          end
       end
    end
    
    private
    def set_note
       @note = Note.find(params[:id])
    end
    
    private
    def notes_params
       params.require(:note).permit(:title, :user_id, :content) 
    end
end
