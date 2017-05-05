module NotesHelper
  def notes_tree_for(notes)
    notes.map do |note, nested_notes|
      render(note) +
          (nested_notes.size > 0 ? content_tag(:div, notes_tree_for(nested_notes), class: "children") : nil)
    end.join.html_safe
  end
end
