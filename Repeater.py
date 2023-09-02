import keyboard
import threading
import time
import pygetwindow as gw
from plyer import notification
from prettytable import PrettyTable
import tkinter as tk
from tkinter import messagebox


run_flag = False
interval_seconds = 0
start_time = None
max_iterations = 10
initial_active_window  = None
suspend = False

current_thread = None
terminate_thread = threading.Event() # Event to signal thread termination

def suspendProgram():
    global suspend
    if suspend == True:
        suspend = False
        print("You can now use section repeater.")
        # msgbox("Suspended", "Section repeater is suspended.")
        return
    if suspend == False:
        suspend = True
        print("Section repeater is suspended.")
        # msgbox("Unsuspended", "You can now use section repeater.")
        return

def msgbox(title, message):
    root = tk.Tk()
    root.withdraw() # Hide the main window
    messagebox.showinfo(title, message)
    root.update() # Update the main window
    root.destroy() # Close the main window

def repeat10more():
    global run_flag
    if not run_flag:
        print("Iterations can only increase while the loop is running. Please try again.")
        return
    
    global max_iterations 
    max_iterations += 10
    print(f'Iterations increased to {max_iterations} times')

def terminate():
    global run_flag
    run_flag = False
    print('Loop terminated!\n')

def terminateCurrentLoopThread():
    global current_thread
    global terminate_thread

    # Signal the current thread to terminate, if it exists
    if current_thread and current_thread.is_alive():
        terminate_thread.set()
        current_thread.join() # Wait for the current thread to finish


def setStartPoint():
    global initial_active_window 
    initial_active_window  = gw.getActiveWindow()

    global max_iterations
    max_iterations = 10

    global run_flag    
    run_flag = True

    global start_time 
    start_time = time.time()
    print('\nStarting point marked in', f"{initial_active_window.title}")

    terminateCurrentLoopThread()

def startSingleThreadLoop():
    global interval_seconds
    interval_seconds = time.time() - start_time

    terminateCurrentLoopThread()

    # Reset the termination signal and start a new thread
    terminate_thread.clear()
    current_thread = threading.Thread(target=loopVideo)
    current_thread.start()


def loopVideo():
    global suspend
    global initial_active_window  #only send input in video windows

    global run_flag 
    run_flag = True

    global start_time

    if not suspend:
        print(f'Looping {interval_seconds:.2f} seconds')

    global max_iterations
    iterations = 0

    while run_flag and not terminate_thread.is_set() and not suspend: # Check for termination signal
        current_active_window = gw.getActiveWindow()
        if current_active_window != initial_active_window:
            initial_active_window.activate()

        keyboard.send(']')
        # current_active_window.activate()
        start_time = time.time()
        
        iterations += 1
        print(iterations, "times")
        if iterations >= max_iterations and not terminate_thread.is_set():
            print('Maximum iterations reached \n')
            run_flag = False  # Set run flag to false when max iterations are reached
            break
        
        time.sleep(interval_seconds)


def loop(interval):
    keyboard.send(']')



def main():
    # notification.notify(
    # title='今日もいい一日をね',
    # message='Section repeater has started',
    # app_name='Section repeater',
    # timeout=5  # The notification will be visible for 5 seconds
    # )

    # print('\nビデオを通じて学ぶためのセクションリピーターのユーティリティへようこそ!\n')
    msgbox("Welcome", "Section repeater has started")
    print("\n--------------------------------------")
    print(' Welcome to Section Repeater Utility!')
    print("--------------------------------------\n")
    print('This utility is effective on videos opening in a Chromium based browser (Brave, Edge, Coc Coc, Chrome, etc.) \nwith Video Speed Controller extension enabled and shortcuts set as in the following table.')
    print('https://chrome.google.com/webstore/detail/video-speed-controller/nffaoalbilbmmfgbnbgppjihopabppdk\n')
    

    table = PrettyTable()
    table.add_column("Shortcut", ["W", "E", "R", "T", "Ctrl + F3","Delete","]"]) 
    table.add_column("Repeater Function", ["Mark beginning", "Mark ending/Start looping", "Repeat 10 more times", "Exit loop", "Suspend/Unsuspend", "Exit program", ""])
    table.add_column("Video Speed Controller Function", ["Set marker", "", "", "", "", "", "Jump to marker"])

    print(table)

    keyboard.add_hotkey('r', repeat10more)
    keyboard.add_hotkey('t', terminate)
    keyboard.add_hotkey('e', lambda: threading.Thread(target=startSingleThreadLoop).start())
    keyboard.add_hotkey('w', setStartPoint)
    keyboard.add_hotkey('Ctrl + F3', suspendProgram)
    keyboard.wait('Delete')
  
    



if __name__ == '__main__':
    main()
    # notification.notify(
    # title='またね！',
    # message='The program will exit',
    # app_name='Section repeater',
    # timeout=3  # The notification will be visible for 3 seconds
    # )