return {
	require("neo-tree").setup({
	  filesystem = {
	    follow_current_file = true, -- Automatically focus the current file
	  },
	  window = {
	    position = "right", -- Open Neo-tree on the right side
	    width = 30,         -- Set the width of the Neo-tree window
	  },
	})
}
