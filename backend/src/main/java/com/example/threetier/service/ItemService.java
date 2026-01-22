package com.example.threetier.service;

import com.example.threetier.entity.ItemEntity;
import com.example.threetier.repository.ItemRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class ItemService {
    
    @Autowired
    private ItemRepository itemRepository;
    
    public List<ItemEntity> getAllItems() {
        return itemRepository.findAll();
    }
    
    public Optional<ItemEntity> getItemById(Long id) {
        return itemRepository.findById(id);
    }
    
    public ItemEntity createItem(ItemEntity item) {
        return itemRepository.save(item);
    }
    
    public ItemEntity updateItem(Long id, ItemEntity itemDetails) {
        ItemEntity item = itemRepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Item not found"));
        
        item.setName(itemDetails.getName());
        item.setDescription(itemDetails.getDescription());
        return itemRepository.save(item);
    }
    
    public void deleteItem(Long id) {
        itemRepository.deleteById(id);
    }
}
