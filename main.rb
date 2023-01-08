require 'tk'

# Create the main window
root = TkRoot.new
root.title = "Notepad"

# Create a menu bar
menu_bar = TkMenu.new(root)

# Create a file menu
file_menu = TkMenu.new(menu_bar)
file_menu.add('command',
  'label' => "Open",
  'command' => proc { open_file }
)
file_menu.add('command',
  'label' => "Save",
  'command' => proc { save_file }
)
file_menu.add('command',
  'label' => "Save As...",
  'command' => proc { save_file_as }
)
menu_bar.add('cascade',
  'menu' => file_menu,
  'label' => "File"
)

# Create an appearance menu
appearance_menu = TkMenu.new(menu_bar)
appearance_menu.add('command',
  'label' => "Customize...",
  'command' => proc { customize_appearance }
)
menu_bar.add('cascade',
  'menu' => appearance_menu,
  'label' => "Appearance"
)

# Create a styling menu
styling_menu = TkMenu.new(menu_bar)
styling_menu.add('command',
  'label' => "Bold",
  'command' => proc { set_bold }
)
styling_menu.add('command',
  'label' => "Italics",
  'command' => proc { set_italics }
)
styling_menu.add('command',
  'label' => "Condensed",
  'command' => proc { set_condensed }
)
menu_bar.add('cascade',
  'menu' => styling_menu,
  'label' => "Styling"
)

# Configure the menu bar for the main window
root.menu(menu_bar)

# Create a text area
text = TkText.new(root)
text.pack

# Define the open_file function
def open_file
  # Open a file dialog to choose a file to open
  file_path = Tk.getOpenFile
  
  # Read the contents of the file
  contents = File.read(file_path)
  
  # Insert the contents of the file into the text area
  text.insert("end", contents)
end

# Define the save_file function
def save_file
  # Get the contents of the text area
  contents = text.value

  # Open a file for writing
  File.open("note.txt", "w") do |file|
    # Write the contents of the text area to the file
    file.write(contents)
  end
end

# Define the save_file_as function
def save_file_as
  # Get the contents of the text area
  contents = text.value
  
  # Open a file dialog to choose a filename and location
  file_path = Tk.getSaveFile
  
  # Write the contents of the text area to the file
  File.open(file_path, "w") do |file|
    file.write(contents)
  end
end

def customize_appearance
  # Create a font picker widget
  font_picker = TkOptionMenu.new(root, 'font', 'Arial', 'Helvetica', 'Times New Roman')
  font_picker.pack

  # Create a light mode button
  light_button = TkButton.new(root) do
    text "Light mode"
    command { set_light_mode }
  end
  light_button.pack

  # Create a dark mode button
  dark_button = TkButton.new(root) do
    text "Dark mode"
    command { set_dark_mode }
  end
  dark_button.pack

  # Create a checkbox to toggle line numbers
  line_numbers_checkbox = TkMenuCheckButton.new(root,
    'text' => "Show line numbers",
    'variable' => line_numbers,
    'onvalue' => 1,
    'offvalue' => 0,
    'command' => proc { toggle_line_numbers }
  )
  line_numbers_checkbox.pack
end

# Define the toggle_line_numbers function
def toggle_line_numbers
  if line_numbers.get == 1
    # Show line numbers
    text.configure('width' => 80, 'padx' => 10, 'pady' => 10, 'border' => 2, 'relief' => 'sunken')
  else
    # Hide line numbers
    text.configure('width' => 80, 'padx' => 0, 'pady' => 0, 'border' => 0, 'relief' => 'flat')
  end
end
