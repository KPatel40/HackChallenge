# Overview

Welcome to the Vinyl Collection Manager App README! This iOS application allows users to manage their vinyl collections. Users can view vinyl details, update information, and interact with their collection seamlessly.

# Dependencies

UIKit: Framework for building the iOS user interface.

Foundation: Provides fundamental data types, serialization, and networking capabilities.

Swift standard library: Core functionality for Swift programming.

Xcode: Integrated development environment (IDE) for macOS.

# Features

ViewController: Displays a list of vinyls using a UITableView.

CustomView: Custom UITableViewCell for displaying vinyl details.

OrganizeTable: Allows editing of vinyl details like title, artist, and genre.

NetworkManager: Handles HTTP requests to fetch vinyl data from a remote server.

VinylData: Represents vinyl information including ID, name, artist, year, image, songs, and users.

# Installation

Clone the repository and open it in Xcode with the following code:

    git clone https://github.com/your-username/your-repository.git
    
    cd your-repository
    
    open VinylCollection.xcodeproj

Ensure you have Xcode installed on your macOS system.

# Usage

Run the application on a simulator or a physical device.

The main screen (ViewController) lists all vinyl items fetched from the server.

Tap on a vinyl item to view details or edit its information in the OrganizeTable view.

Changes made in OrganizeTable are updated in real-time on the main screen (ViewController).
