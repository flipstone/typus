class Typus::PagesController < Typus::ResourcesController

  def rebuild_all
    redirect_to :back, :notice => "Entries have been rebuilt."
  end

end
