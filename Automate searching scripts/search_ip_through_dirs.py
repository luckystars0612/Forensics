import os
import threading
import logging
import re
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

# Regular expression for IPv4 addresses
IP_REGEX = re.compile(r'(?:\d{1,3}\.){3}\d{1,3}')

def search_ip_in_file(file_path):
    """Search for IP addresses in a file."""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            matches = IP_REGEX.findall(content)
            if matches:
                logging.info(f"[FOUND - TEXT] IP(s) {matches} in {file_path}")
    except UnicodeDecodeError:
        # Handle binary files
        try:
            with open(file_path, 'rb') as f:
                content = f.read()
                content_ascii = content.decode('ascii', errors='ignore')
                matches = IP_REGEX.findall(content_ascii)
                if matches:
                    logging.info(f"[FOUND - BINARY] IP(s) {matches} in {file_path}")
        except Exception as e:
            logging.error(f"[ERROR] Could not read {file_path} as binary: {e}")
    except Exception as e:
        logging.error(f"[ERROR] Could not read {file_path}: {e}")

def worker(queue):
    """Worker thread to process files."""
    while not queue.empty():
        file_path = queue.get()
        if os.path.isfile(file_path):
            logging.info(f"[SEARCHING] {file_path}")
            search_ip_in_file(file_path)
        queue.task_done()

def traverse_and_search(root_dir, num_threads=4):
    """Traverse directories and search for IP addresses in files using multithreading."""
    file_queue = Queue()

    # Traverse the directory and enqueue file paths
    for subdir, _, files in os.walk(root_dir):
        for file in files:
            file_path = os.path.join(subdir, file)
            file_queue.put(file_path)

    # Create threads
    threads = []
    for _ in range(num_threads):
        thread = threading.Thread(target=worker, args=(file_queue,))
        thread.start()
        threads.append(thread)

    # Wait for all threads to finish
    file_queue.join()
    for thread in threads:
        thread.join()

if __name__ == "__main__":
    root_directory = input("Enter the root directory to search: ")
    num_threads = int(input("Enter the number of threads to use: "))

    logging.info(f"[START] Searching for IP addresses in {root_directory} with {num_threads} threads")
    traverse_and_search(root_directory, num_threads)
    logging.info("[COMPLETED] Search process finished")
