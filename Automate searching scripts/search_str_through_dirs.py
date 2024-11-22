import os
import threading
import logging
from queue import Queue

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s',
    handlers=[
        logging.FileHandler("search.log"),
        logging.StreamHandler()
    ]
)

def search_string_in_file(file_path, target_string):
    """Search for a target string in a file."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            if target_string in content:
                logging.info(f"[FOUND - TEXT] {target_string} in {file_path}")
    except UnicodeDecodeError:
        # Handle binary files
        try:
            with open(file_path, 'rb') as f:
                content = f.read()
                content_ascii = content.decode('ascii', errors='ignore')
                if target_string in content_ascii:
                    logging.info(f"[FOUND - BINARY] {target_string} in {file_path}")
        except Exception as e:
            logging.error(f"[ERROR] Could not read {file_path} as binary: {e}")
    except Exception as e:
        logging.error(f"[ERROR] Could not read {file_path}: {e}")

def worker(queue, target_string):
    """Worker thread to process files."""
    while not queue.empty():
        file_path = queue.get()
        if os.path.isfile(file_path):
            logging.info(f"[SEARCHING] {file_path}")
            search_string_in_file(file_path, target_string)
        queue.task_done()

def traverse_and_search(root_dir, target_string, num_threads=4):
    """Traverse directories and search for the target string in files using multithreading."""
    file_queue = Queue()

    # Traverse the directory and enqueue file paths
    for subdir, _, files in os.walk(root_dir):
        for file in files:
            file_path = os.path.join(subdir, file)
            file_queue.put(file_path)

    # Create threads
    threads = []
    for _ in range(num_threads):
        thread = threading.Thread(target=worker, args=(file_queue, target_string))
        thread.start()
        threads.append(thread)

    # Wait for all threads to finish
    file_queue.join()
    for thread in threads:
        thread.join()

if __name__ == "__main__":
    def get_target_string():
        """Define the target string to search."""
        return input("Enter the target string to search for: ").strip()

    root_directory = input("Enter the root directory to search: ")
    target = get_target_string()
    num_threads = int(input("Enter the number of threads to use: "))

    logging.info(f"[START] Searching for '{target}' in {root_directory} with {num_threads} threads")
    traverse_and_search(root_directory, target, num_threads)
    logging.info("[COMPLETED] Search process finished")
