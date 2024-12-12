package main

import (
	"fmt"
	"log"
)

// Plugin represents the main plugin structure
type Plugin struct {
	name string
}

// NewPlugin creates and initializes a new plugin instance
func NewPlugin() *Plugin {
	return &Plugin{
		name: "umbeluzi-bar",
	}
}

// Run executes the main plugin logic
func (p *Plugin) Run() error {
	fmt.Printf("Running %s plugin...\n", p.name)
	// Add your plugin logic here
	return nil
}

// Export marks this function as the entry point for the WebAssembly module
//export run
func run() {
	plugin := NewPlugin()
	if err := plugin.Run(); err != nil {
		log.Printf("Plugin error: %v\n", err)
		// In WASM we can't use os.Exit, so we'll just return
		return
	}
}

// main is required for the TinyGo compiler but won't be used in WASM
func main() {
	run()
}
